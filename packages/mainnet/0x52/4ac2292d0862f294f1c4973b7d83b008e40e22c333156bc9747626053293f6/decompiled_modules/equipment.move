module 0x524ac2292d0862f294f1c4973b7d83b008e40e22c333156bc9747626053293f6::equipment {
    struct EQUIPMENT has drop {
        dummy_field: bool,
    }

    struct Equipment has store, key {
        id: 0x2::object::UID,
        game_id: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        slot: 0x1::string::String,
        rarity: 0x1::string::String,
    }

    struct EquipmentMintAuth has store, key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
        mint_limit: u64,
        mint_count: u64,
    }

    struct PanzerdogsMutationAuth has store, key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
        mutation_count: u64,
    }

    struct EquipmentSlot has copy, drop, store {
        slot: 0x1::string::String,
    }

    struct ImageHashValidator has key {
        id: 0x2::object::UID,
        dogs: vector<0x2::object::ID>,
        image_hashes: vector<0x1::string::String>,
    }

    struct EquipmentOperationReceipt {
        equip: u64,
        unequip: u64,
    }

    struct EquipmentMintedEvent has copy, drop {
        id: 0x2::object::ID,
        game_id: 0x1::string::String,
        sender: address,
    }

    struct EquipmentEquippedEvent has copy, drop {
        dog: 0x2::object::ID,
        equipment: 0x2::object::ID,
        sender: address,
    }

    struct EquipmentUnequippedEvent has copy, drop {
        dog: 0x2::object::ID,
        equipment: 0x2::object::ID,
        sender: address,
    }

    struct PanzerdogMutatedEvent has copy, drop {
        id: 0x2::object::ID,
        sender: address,
    }

    public entry fun add_dog_image_hash_to_validator(arg0: address, arg1: 0x1::string::String, arg2: &mut ImageHashValidator, arg3: &mut PanzerdogsMutationAuth) {
        let v0 = 0x2::object::id_from_address(arg0);
        let (v1, v2) = 0x1::vector::index_of<0x2::object::ID>(&arg2.dogs, &v0);
        if (v1) {
            0x1::vector::push_back<0x1::string::String>(&mut arg2.image_hashes, arg1);
            0x1::vector::swap_remove<0x1::string::String>(&mut arg2.image_hashes, v2);
        } else {
            0x1::vector::push_back<0x2::object::ID>(&mut arg2.dogs, v0);
            0x1::vector::push_back<0x1::string::String>(&mut arg2.image_hashes, arg1);
        };
    }

    public entry fun clear_image_hash_validator(arg0: &mut ImageHashValidator, arg1: &mut PanzerdogsMutationAuth) {
        arg0.dogs = 0x1::vector::empty<0x2::object::ID>();
        arg0.image_hashes = 0x1::vector::empty<0x1::string::String>();
    }

    public fun equip(arg0: &mut 0x524ac2292d0862f294f1c4973b7d83b008e40e22c333156bc9747626053293f6::panzerdogs::Panzerdog, arg1: Equipment, arg2: &mut EquipmentOperationReceipt, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.equip > 0, 6);
        let v0 = EquipmentSlot{slot: arg1.slot};
        if (0x2::dynamic_object_field::exists_<EquipmentSlot>(0x524ac2292d0862f294f1c4973b7d83b008e40e22c333156bc9747626053293f6::panzerdogs::uid_mut(arg0), v0)) {
            unequip_without_receipt(arg0, arg1.slot, arg3);
        };
        let v1 = EquipmentEquippedEvent{
            dog       : 0x2::object::id<0x524ac2292d0862f294f1c4973b7d83b008e40e22c333156bc9747626053293f6::panzerdogs::Panzerdog>(arg0),
            equipment : 0x2::object::id<Equipment>(&arg1),
            sender    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<EquipmentEquippedEvent>(v1);
        let v2 = EquipmentSlot{slot: arg1.slot};
        0x2::dynamic_object_field::add<EquipmentSlot, Equipment>(0x524ac2292d0862f294f1c4973b7d83b008e40e22c333156bc9747626053293f6::panzerdogs::uid_mut(arg0), v2, arg1);
        arg2.equip = arg2.equip - 1;
    }

    fun equip_without_receipt(arg0: &mut 0x524ac2292d0862f294f1c4973b7d83b008e40e22c333156bc9747626053293f6::panzerdogs::Panzerdog, arg1: Equipment, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = EquipmentSlot{slot: arg1.slot};
        assert!(!0x2::dynamic_object_field::exists_<EquipmentSlot>(0x524ac2292d0862f294f1c4973b7d83b008e40e22c333156bc9747626053293f6::panzerdogs::uid_mut(arg0), v0), 8);
        let v1 = EquipmentEquippedEvent{
            dog       : 0x2::object::id<0x524ac2292d0862f294f1c4973b7d83b008e40e22c333156bc9747626053293f6::panzerdogs::Panzerdog>(arg0),
            equipment : 0x2::object::id<Equipment>(&arg1),
            sender    : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<EquipmentEquippedEvent>(v1);
        let v2 = EquipmentSlot{slot: arg1.slot};
        0x2::dynamic_object_field::add<EquipmentSlot, Equipment>(0x524ac2292d0862f294f1c4973b7d83b008e40e22c333156bc9747626053293f6::panzerdogs::uid_mut(arg0), v2, arg1);
    }

    fun get_dog_image_hash(arg0: &0x2::object::ID, arg1: &ImageHashValidator) : 0x1::string::String {
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg1.dogs, arg0);
        assert!(v0, 7);
        *0x1::vector::borrow<0x1::string::String>(&arg1.image_hashes, v1)
    }

    fun init(arg0: EQUIPMENT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<EQUIPMENT>(arg0, arg1);
        let v1 = EquipmentMintAuth{
            id          : 0x2::object::new(arg1),
            description : 0x1::string::utf8(b"Mint Authority for Panzerdogs Equipment"),
            mint_limit  : 0,
            mint_count  : 0,
        };
        let v2 = PanzerdogsMutationAuth{
            id             : 0x2::object::new(arg1),
            description    : 0x1::string::utf8(b"Mutation Authority for Panzerdogs"),
            mutation_count : 0,
        };
        let v3 = ImageHashValidator{
            id           : 0x2::object::new(arg1),
            dogs         : 0x1::vector::empty<0x2::object::ID>(),
            image_hashes : 0x1::vector::empty<0x1::string::String>(),
        };
        0x2::transfer::share_object<ImageHashValidator>(v3);
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"game_id"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"slot"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"image_url"));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{game_id}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{slot}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://www.panzerdogs.io"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"Lucky Kat Studios"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"ipfs://QmUahahXvCiWVUPVLAoQUEwiEhiVscBTnRkHWErVN6aWCU/{slot}/{game_id}.png"));
        let v8 = 0x2::display::new_with_fields<Equipment>(&v0, v4, v6, arg1);
        0x2::display::update_version<Equipment>(&mut v8);
        0x2::transfer::public_transfer<EquipmentMintAuth>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<PanzerdogsMutationAuth>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Equipment>>(v8, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun init_equip(arg0: u64, arg1: u64) : EquipmentOperationReceipt {
        assert!(arg0 != 0 || arg1 != 0, 6);
        EquipmentOperationReceipt{
            equip   : arg0,
            unequip : arg1,
        }
    }

    fun internal_remove_dog_image_hash_from_validator(arg0: &0x2::object::ID, arg1: &mut ImageHashValidator) {
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg1.dogs, arg0);
        assert!(v0, 7);
        0x1::vector::remove<0x2::object::ID>(&mut arg1.dogs, v1);
        0x1::vector::remove<0x1::string::String>(&mut arg1.image_hashes, v1);
    }

    public fun mint_and_equip(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut EquipmentMintAuth, arg6: &mut 0x524ac2292d0862f294f1c4973b7d83b008e40e22c333156bc9747626053293f6::panzerdogs::Panzerdog, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg5.mint_limit > 0) {
            assert!(arg5.mint_count < arg5.mint_limit, 2);
        };
        assert!(validate_slot(arg3), 5);
        let v0 = Equipment{
            id          : 0x2::object::new(arg7),
            game_id     : arg0,
            name        : arg1,
            description : arg2,
            slot        : arg3,
            rarity      : arg4,
        };
        arg5.mint_count = arg5.mint_count + 1;
        let v1 = EquipmentMintedEvent{
            id      : 0x2::object::id<Equipment>(&v0),
            game_id : arg0,
            sender  : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<EquipmentMintedEvent>(v1);
        equip_without_receipt(arg6, v0, arg7);
    }

    public entry fun mint_auth_to_address(arg0: &0x2::package::Publisher, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<Equipment>(arg0), 1);
        let v0 = EquipmentMintAuth{
            id          : 0x2::object::new(arg3),
            description : 0x1::string::utf8(b"Mint Authority for Panzerdogs Equipment"),
            mint_limit  : arg1,
            mint_count  : 0,
        };
        0x2::transfer::public_transfer<EquipmentMintAuth>(v0, arg2);
    }

    public fun mint_ptb(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut EquipmentMintAuth, arg6: &mut 0x2::tx_context::TxContext) : Equipment {
        if (arg5.mint_limit > 0) {
            assert!(arg5.mint_count < arg5.mint_limit, 2);
        };
        assert!(validate_slot(arg3), 5);
        let v0 = Equipment{
            id          : 0x2::object::new(arg6),
            game_id     : arg0,
            name        : arg1,
            description : arg2,
            slot        : arg3,
            rarity      : arg4,
        };
        arg5.mint_count = arg5.mint_count + 1;
        let v1 = EquipmentMintedEvent{
            id      : 0x2::object::id<Equipment>(&v0),
            game_id : arg0,
            sender  : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<EquipmentMintedEvent>(v1);
        v0
    }

    public entry fun mint_to_address(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: address, arg6: &mut EquipmentMintAuth, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg6.mint_limit > 0) {
            assert!(arg6.mint_count < arg6.mint_limit, 2);
        };
        assert!(validate_slot(arg3), 5);
        let v0 = Equipment{
            id          : 0x2::object::new(arg7),
            game_id     : arg0,
            name        : arg1,
            description : arg2,
            slot        : arg3,
            rarity      : arg4,
        };
        arg6.mint_count = arg6.mint_count + 1;
        let v1 = EquipmentMintedEvent{
            id      : 0x2::object::id<Equipment>(&v0),
            game_id : arg0,
            sender  : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<EquipmentMintedEvent>(v1);
        0x2::transfer::public_transfer<Equipment>(v0, arg5);
    }

    public(friend) fun mint_to_address_pkg(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(validate_slot(arg3), 5);
        let v0 = Equipment{
            id          : 0x2::object::new(arg6),
            game_id     : arg0,
            name        : arg1,
            description : arg2,
            slot        : arg3,
            rarity      : arg4,
        };
        let v1 = EquipmentMintedEvent{
            id      : 0x2::object::id<Equipment>(&v0),
            game_id : arg0,
            sender  : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<EquipmentMintedEvent>(v1);
        0x2::transfer::public_transfer<Equipment>(v0, arg5);
    }

    public entry fun mutate_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::display::Display<Equipment>) {
        assert!(0x2::package::from_package<Equipment>(arg0), 1);
        0x2::display::edit<Equipment>(arg3, arg1, arg2);
        0x2::display::update_version<Equipment>(arg3);
    }

    public fun mutate_dog_image_hash(arg0: &mut 0x524ac2292d0862f294f1c4973b7d83b008e40e22c333156bc9747626053293f6::panzerdogs::Panzerdog, arg1: &mut ImageHashValidator, arg2: EquipmentOperationReceipt, arg3: &mut 0x2::tx_context::TxContext) {
        let EquipmentOperationReceipt {
            equip   : v0,
            unequip : v1,
        } = arg2;
        assert!(v0 == 0 && v1 == 0, 6);
        let v2 = 0x2::object::id<0x524ac2292d0862f294f1c4973b7d83b008e40e22c333156bc9747626053293f6::panzerdogs::Panzerdog>(arg0);
        0x524ac2292d0862f294f1c4973b7d83b008e40e22c333156bc9747626053293f6::panzerdogs::mutate_image_hash(arg0, get_dog_image_hash(&v2, arg1));
        let v3 = PanzerdogMutatedEvent{
            id     : 0x2::object::id<0x524ac2292d0862f294f1c4973b7d83b008e40e22c333156bc9747626053293f6::panzerdogs::Panzerdog>(arg0),
            sender : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<PanzerdogMutatedEvent>(v3);
        let v4 = 0x2::object::id<0x524ac2292d0862f294f1c4973b7d83b008e40e22c333156bc9747626053293f6::panzerdogs::Panzerdog>(arg0);
        internal_remove_dog_image_hash_from_validator(&v4, arg1);
    }

    public entry fun mutation_auth_to_address(arg0: &0x2::package::Publisher, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<Equipment>(arg0), 1);
        let v0 = PanzerdogsMutationAuth{
            id             : 0x2::object::new(arg2),
            description    : 0x1::string::utf8(b"Mutation Authority for Panzerdogs"),
            mutation_count : 0,
        };
        0x2::transfer::public_transfer<PanzerdogsMutationAuth>(v0, arg1);
    }

    public entry fun new_image_mutation_validator(arg0: &mut PanzerdogsMutationAuth, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ImageHashValidator{
            id           : 0x2::object::new(arg1),
            dogs         : 0x1::vector::empty<0x2::object::ID>(),
            image_hashes : 0x1::vector::empty<0x1::string::String>(),
        };
        0x2::transfer::share_object<ImageHashValidator>(v0);
    }

    public entry fun remove_dog_image_hash_from_validator(arg0: address, arg1: &mut ImageHashValidator, arg2: &mut PanzerdogsMutationAuth) {
        let v0 = 0x2::object::id_from_address(arg0);
        let (v1, v2) = 0x1::vector::index_of<0x2::object::ID>(&arg1.dogs, &v0);
        assert!(v1, 7);
        0x1::vector::remove<0x2::object::ID>(&mut arg1.dogs, v2);
        0x1::vector::remove<0x1::string::String>(&mut arg1.image_hashes, v2);
    }

    public(friend) fun slot(arg0: &Equipment) : 0x1::string::String {
        arg0.slot
    }

    public(friend) fun uid_mut(arg0: &mut Equipment) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun unequip(arg0: &mut 0x524ac2292d0862f294f1c4973b7d83b008e40e22c333156bc9747626053293f6::panzerdogs::Panzerdog, arg1: 0x1::string::String, arg2: &mut EquipmentOperationReceipt, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != 0x1::string::utf8(b"Augment"), 3);
        let v0 = EquipmentSlot{slot: arg1};
        assert!(0x2::dynamic_object_field::exists_<EquipmentSlot>(0x524ac2292d0862f294f1c4973b7d83b008e40e22c333156bc9747626053293f6::panzerdogs::uid_mut(arg0), v0), 4);
        assert!(arg2.unequip > 0, 6);
        let v1 = EquipmentSlot{slot: arg1};
        let v2 = 0x2::dynamic_object_field::remove<EquipmentSlot, Equipment>(0x524ac2292d0862f294f1c4973b7d83b008e40e22c333156bc9747626053293f6::panzerdogs::uid_mut(arg0), v1);
        let v3 = EquipmentUnequippedEvent{
            dog       : 0x2::object::id<0x524ac2292d0862f294f1c4973b7d83b008e40e22c333156bc9747626053293f6::panzerdogs::Panzerdog>(arg0),
            equipment : 0x2::object::id<Equipment>(&v2),
            sender    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<EquipmentUnequippedEvent>(v3);
        arg2.unequip = arg2.unequip - 1;
        0x2::transfer::public_transfer<Equipment>(v2, 0x2::tx_context::sender(arg3));
    }

    fun unequip_without_receipt(arg0: &mut 0x524ac2292d0862f294f1c4973b7d83b008e40e22c333156bc9747626053293f6::panzerdogs::Panzerdog, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != 0x1::string::utf8(b"Augment"), 3);
        let v0 = EquipmentSlot{slot: arg1};
        assert!(0x2::dynamic_object_field::exists_<EquipmentSlot>(0x524ac2292d0862f294f1c4973b7d83b008e40e22c333156bc9747626053293f6::panzerdogs::uid_mut(arg0), v0), 4);
        let v1 = EquipmentSlot{slot: arg1};
        let v2 = 0x2::dynamic_object_field::remove<EquipmentSlot, Equipment>(0x524ac2292d0862f294f1c4973b7d83b008e40e22c333156bc9747626053293f6::panzerdogs::uid_mut(arg0), v1);
        let v3 = EquipmentUnequippedEvent{
            dog       : 0x2::object::id<0x524ac2292d0862f294f1c4973b7d83b008e40e22c333156bc9747626053293f6::panzerdogs::Panzerdog>(arg0),
            equipment : 0x2::object::id<Equipment>(&v2),
            sender    : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<EquipmentUnequippedEvent>(v3);
        0x2::transfer::public_transfer<Equipment>(v2, 0x2::tx_context::sender(arg2));
    }

    public fun validate_slot(arg0: 0x1::string::String) : bool {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Colour"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Body"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Neck"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Mouth"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Head"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Eyes"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Background"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Augment"));
        0x1::vector::contains<0x1::string::String>(&v0, &arg0)
    }

    // decompiled from Move bytecode v6
}

