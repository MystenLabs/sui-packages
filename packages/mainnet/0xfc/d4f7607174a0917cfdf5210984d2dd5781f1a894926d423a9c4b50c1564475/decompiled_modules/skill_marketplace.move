module 0x8753bf39265f8e209f0a3c643c3dcec32348216cd3354e0aacae988ae54869a2::skill_marketplace {
    struct SkillRecord has store, key {
        id: 0x2::object::UID,
        blob_id: u256,
        creator: address,
        title: vector<u8>,
        description: vector<u8>,
        price: u64,
        scene: vector<u8>,
        network: vector<u8>,
        package_id: vector<u8>,
        is_encrypted: bool,
        total_sales: u64,
        total_revenue: u64,
        created_at: u64,
    }

    struct AccessCap has store, key {
        id: 0x2::object::UID,
        skill_id: 0x2::object::ID,
        blob_id: u256,
        purchased_at: u64,
    }

    struct SkillPublished has copy, drop {
        skill_id: 0x2::object::ID,
        creator: address,
        blob_id: u256,
        price: u64,
        is_encrypted: bool,
    }

    struct SkillPurchased has copy, drop {
        skill_id: 0x2::object::ID,
        buyer: address,
        access_cap_id: 0x2::object::ID,
        price: u64,
    }

    struct FreeSkillClaimed has copy, drop {
        skill_id: 0x2::object::ID,
        claimer: address,
        access_cap_id: 0x2::object::ID,
    }

    struct PriceUpdated has copy, drop {
        skill_id: 0x2::object::ID,
        old_price: u64,
        new_price: u64,
    }

    public fun claim_free_skill(arg0: &SkillRecord, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.price == 0, 3);
        let v0 = AccessCap{
            id           : 0x2::object::new(arg2),
            skill_id     : 0x2::object::id<SkillRecord>(arg0),
            blob_id      : arg0.blob_id,
            purchased_at : 0x2::clock::timestamp_ms(arg1),
        };
        let v1 = FreeSkillClaimed{
            skill_id      : 0x2::object::id<SkillRecord>(arg0),
            claimer       : 0x2::tx_context::sender(arg2),
            access_cap_id : 0x2::object::id<AccessCap>(&v0),
        };
        0x2::event::emit<FreeSkillClaimed>(v1);
        0x2::transfer::transfer<AccessCap>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun get_access_blob_id(arg0: &AccessCap) : u256 {
        arg0.blob_id
    }

    public fun get_access_skill_id(arg0: &AccessCap) : 0x2::object::ID {
        arg0.skill_id
    }

    public fun get_blob_id(arg0: &SkillRecord) : u256 {
        arg0.blob_id
    }

    public fun get_creator(arg0: &SkillRecord) : address {
        arg0.creator
    }

    public fun get_price(arg0: &SkillRecord) : u64 {
        arg0.price
    }

    public fun get_total_revenue(arg0: &SkillRecord) : u64 {
        arg0.total_revenue
    }

    public fun get_total_sales(arg0: &SkillRecord) : u64 {
        arg0.total_sales
    }

    public fun is_encrypted(arg0: &SkillRecord) : bool {
        arg0.is_encrypted
    }

    public fun is_free(arg0: &SkillRecord) : bool {
        arg0.price == 0
    }

    public fun publish_skill(arg0: u256, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = SkillRecord{
            id            : 0x2::object::new(arg9),
            blob_id       : arg0,
            creator       : v0,
            title         : arg1,
            description   : arg2,
            price         : arg3,
            scene         : arg4,
            network       : arg5,
            package_id    : arg6,
            is_encrypted  : arg7,
            total_sales   : 0,
            total_revenue : 0,
            created_at    : 0x2::clock::timestamp_ms(arg8),
        };
        let v2 = SkillPublished{
            skill_id     : 0x2::object::id<SkillRecord>(&v1),
            creator      : v0,
            blob_id      : arg0,
            price        : arg3,
            is_encrypted : arg7,
        };
        0x2::event::emit<SkillPublished>(v2);
        0x2::transfer::share_object<SkillRecord>(v1);
    }

    public fun purchase_skill(arg0: &mut SkillRecord, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.price > 0, 4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.price, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg0.price, arg3), arg0.creator);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        arg0.total_sales = arg0.total_sales + 1;
        arg0.total_revenue = arg0.total_revenue + arg0.price;
        let v0 = AccessCap{
            id           : 0x2::object::new(arg3),
            skill_id     : 0x2::object::id<SkillRecord>(arg0),
            blob_id      : arg0.blob_id,
            purchased_at : 0x2::clock::timestamp_ms(arg2),
        };
        let v1 = SkillPurchased{
            skill_id      : 0x2::object::id<SkillRecord>(arg0),
            buyer         : 0x2::tx_context::sender(arg3),
            access_cap_id : 0x2::object::id<AccessCap>(&v0),
            price         : arg0.price,
        };
        0x2::event::emit<SkillPurchased>(v1);
        0x2::transfer::transfer<AccessCap>(v0, 0x2::tx_context::sender(arg3));
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &SkillRecord, arg2: &AccessCap) {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v0));
        assert!(arg2.skill_id == v1, 5);
        assert!(0x2::object::id<SkillRecord>(arg1) == v1, 5);
    }

    entry fun seal_approve_free(arg0: vector<u8>, arg1: &SkillRecord) {
        assert!(arg1.price == 0, 3);
        let v0 = 0x2::bcs::new(arg0);
        assert!(0x2::object::id<SkillRecord>(arg1) == 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v0)), 5);
    }

    entry fun seal_approve_free_v2(arg0: vector<u8>, arg1: &SkillRecord) {
        assert!(arg1.price == 0, 3);
    }

    entry fun seal_approve_v2(arg0: vector<u8>, arg1: &SkillRecord, arg2: &AccessCap) {
        assert!(arg2.skill_id == 0x2::object::id<SkillRecord>(arg1), 5);
    }

    public fun update_blob(arg0: &mut SkillRecord, arg1: u256, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg3), 2);
        arg0.blob_id = arg1;
        arg0.is_encrypted = arg2;
    }

    public fun update_price(arg0: &mut SkillRecord, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 2);
        arg0.price = arg1;
        let v0 = PriceUpdated{
            skill_id  : 0x2::object::id<SkillRecord>(arg0),
            old_price : arg0.price,
            new_price : arg1,
        };
        0x2::event::emit<PriceUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

