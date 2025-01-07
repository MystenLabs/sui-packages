module 0x1e5b3a72600891447fe46c506e31bdfed1704bcb188fe2240d4865a862e1e929::suipaynft {
    struct CreatorCap has key {
        id: 0x2::object::UID,
    }

    struct ContractInfo has key {
        id: 0x2::object::UID,
        owner_address: address,
        required_payment: u64,
        count: u16,
        nftsUsed: vector<bool>,
        features: vector<Feature>,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        nr: 0x1::string::String,
        traits: 0x2::table::Table<0x1::string::String, 0x1::string::String>,
        displayTraits: DisplayTrait,
    }

    struct Whitelist has store, key {
        id: 0x2::object::UID,
        discountPct: u8,
        key: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct Trait has drop, store {
        name: 0x1::string::String,
        chancePm: u64,
    }

    struct Feature has drop, store {
        name: 0x1::string::String,
        traits: vector<Trait>,
    }

    struct DisplayTrait has drop, store {
        background: 0x1::string::String,
        body: 0x1::string::String,
        decoration: 0x1::string::String,
        face: 0x1::string::String,
    }

    struct NFTMinted has copy, drop {
        id: 0x2::object::ID,
        minted_by: address,
    }

    struct SUIPAYNFT has drop {
        dummy_field: bool,
    }

    public entry fun add_discount(arg0: &CreatorCap, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Whitelist{
            id          : 0x2::object::new(arg5),
            discountPct : arg4,
            key         : arg2,
            value       : arg3,
        };
        0x2::transfer::public_transfer<Whitelist>(v0, arg1);
    }

    public entry fun add_field(arg0: &CreatorCap, arg1: &mut 0x2::display::Display<NFT>, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        0x2::display::add<NFT>(arg1, arg2, arg3);
    }

    public entry fun add_trait(arg0: &CreatorCap, arg1: &mut NFT, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut arg1.traits, arg2, arg3);
    }

    fun calc_traits(arg0: u32, arg1: &ContractInfo) : vector<Feature> {
        let v0 = 0x1::vector::empty<Feature>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<Feature>(&arg1.features)) {
            let v2 = 0x1::vector::borrow<Feature>(&arg1.features, v1);
            let v3 = 0;
            let v4 = 0x1::vector::length<Trait>(&v2.traits);
            let v5 = 0;
            let v6 = convert2BytesToU16(0x1::hash::sha2_256(u32_to_vector_u8(arg0 + 10696607)), v1 * 2);
            while (v3 < v4) {
                let v7 = 0x1::vector::borrow<Trait>(&v2.traits, v3);
                let v8 = v5 + ((v7.chancePm * 65535 / 1000) as u16);
                if (v6 >= v5 && v6 < v8 || v3 == v4 - 1) {
                    let v9 = 0x1::vector::empty<Trait>();
                    let v10 = Trait{
                        name     : v7.name,
                        chancePm : 0,
                    };
                    0x1::vector::push_back<Trait>(&mut v9, v10);
                    let v11 = Feature{
                        name   : v2.name,
                        traits : v9,
                    };
                    0x1::vector::push_back<Feature>(&mut v0, v11);
                    break
                };
                v5 = v8;
                v3 = v3 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun contract_info(arg0: &ContractInfo) : &ContractInfo {
        arg0
    }

    fun convert(arg0: u16) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        let v1 = b"";
        0x1::vector::push_back<u8>(&mut v1, ((arg0 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v1, ((arg0 & 255) as u8));
        0x1::string::append_utf8(&mut v0, 0x2::hex::encode(v1));
        v0
    }

    fun convert2BytesToU16(arg0: vector<u8>, arg1: u64) : u16 {
        (*0x1::vector::borrow<u8>(&arg0, arg1) as u16) << 8 | (*0x1::vector::borrow<u8>(&arg0, arg1 + 1) as u16)
    }

    public entry fun destroy(arg0: NFT) {
        let NFT {
            id            : v0,
            name          : _,
            nr            : _,
            traits        : v3,
            displayTraits : _,
        } = arg0;
        0x2::table::drop<0x1::string::String, 0x1::string::String>(v3);
        0x2::object::delete(v0);
    }

    public entry fun edit_field(arg0: &CreatorCap, arg1: &mut 0x2::display::Display<NFT>, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        0x2::display::edit<NFT>(arg1, arg2, arg3);
    }

    fun gen_next_free(arg0: u32, arg1: &mut ContractInfo) : u32 {
        let v0;
        loop {
            v0 = 0x1::vector::borrow_mut<bool>(&mut arg1.nftsUsed, (arg0 as u64));
            if (*v0 == false) {
                break
            };
            let v1 = arg0 + 1;
            arg0 = v1 % (50 as u32);
        };
        *v0 = true;
        arg0
    }

    fun init(arg0: SUIPAYNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CreatorCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<CreatorCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://axelra.net/nft/{nr}.html"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://axelra.net/nft/{nr}.png"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Test Sui Pay NFT5"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://axelra.net/nft"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Sui Pay Test Team"));
        let v5 = 0x2::package::claim<SUIPAYNFT>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<NFT>(&v5, v1, v3, arg1);
        0x2::display::update_version<NFT>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v6, 0x2::tx_context::sender(arg1));
        let v7 = 0;
        let v8 = 0x1::vector::empty<bool>();
        while (v7 < 50) {
            0x1::vector::push_back<bool>(&mut v8, false);
            v7 = v7 + 1;
        };
        let v9 = 0x1::vector::empty<Feature>();
        let v10 = 0x1::vector::empty<Trait>();
        let v11 = Trait{
            name     : 0x1::string::utf8(b"Plain"),
            chancePm : 1000,
        };
        0x1::vector::push_back<Trait>(&mut v10, v11);
        let v12 = 0x1::vector::empty<Trait>();
        let v13 = Trait{
            name     : 0x1::string::utf8(b"Green"),
            chancePm : 225,
        };
        0x1::vector::push_back<Trait>(&mut v12, v13);
        let v14 = Trait{
            name     : 0x1::string::utf8(b"Orange"),
            chancePm : 225,
        };
        0x1::vector::push_back<Trait>(&mut v12, v14);
        let v15 = Trait{
            name     : 0x1::string::utf8(b"Pink"),
            chancePm : 225,
        };
        0x1::vector::push_back<Trait>(&mut v12, v15);
        let v16 = Trait{
            name     : 0x1::string::utf8(b"Pride"),
            chancePm : 20,
        };
        0x1::vector::push_back<Trait>(&mut v12, v16);
        let v17 = Trait{
            name     : 0x1::string::utf8(b"Purple"),
            chancePm : 80,
        };
        0x1::vector::push_back<Trait>(&mut v12, v17);
        let v18 = Trait{
            name     : 0x1::string::utf8(b"Red"),
            chancePm : 225,
        };
        0x1::vector::push_back<Trait>(&mut v12, v18);
        let v19 = 0x1::vector::empty<Trait>();
        let v20 = Trait{
            name     : 0x1::string::utf8(b"Frown"),
            chancePm : 200,
        };
        0x1::vector::push_back<Trait>(&mut v19, v20);
        let v21 = Trait{
            name     : 0x1::string::utf8(b"Happy"),
            chancePm : 200,
        };
        0x1::vector::push_back<Trait>(&mut v19, v21);
        let v22 = Trait{
            name     : 0x1::string::utf8(b"Mask"),
            chancePm : 20,
        };
        0x1::vector::push_back<Trait>(&mut v19, v22);
        let v23 = Trait{
            name     : 0x1::string::utf8(b"Pirate"),
            chancePm : 160,
        };
        0x1::vector::push_back<Trait>(&mut v19, v23);
        let v24 = Trait{
            name     : 0x1::string::utf8(b"Sunglasses"),
            chancePm : 20,
        };
        0x1::vector::push_back<Trait>(&mut v19, v24);
        let v25 = Trait{
            name     : 0x1::string::utf8(b"Wink"),
            chancePm : 200,
        };
        0x1::vector::push_back<Trait>(&mut v19, v25);
        let v26 = Trait{
            name     : 0x1::string::utf8(b"Worried"),
            chancePm : 200,
        };
        0x1::vector::push_back<Trait>(&mut v19, v26);
        let v27 = 0x1::vector::empty<Trait>();
        let v28 = Trait{
            name     : 0x1::string::utf8(b"Bubbles"),
            chancePm : 300,
        };
        0x1::vector::push_back<Trait>(&mut v27, v28);
        let v29 = Trait{
            name     : 0x1::string::utf8(b"Coral"),
            chancePm : 300,
        };
        0x1::vector::push_back<Trait>(&mut v27, v29);
        let v30 = Trait{
            name     : 0x1::string::utf8(b"Fishes"),
            chancePm : 300,
        };
        0x1::vector::push_back<Trait>(&mut v27, v30);
        let v31 = Trait{
            name     : 0x1::string::utf8(b"Submarine"),
            chancePm : 80,
        };
        0x1::vector::push_back<Trait>(&mut v27, v31);
        let v32 = Trait{
            name     : 0x1::string::utf8(b"Treasure"),
            chancePm : 20,
        };
        0x1::vector::push_back<Trait>(&mut v27, v32);
        let v33 = Feature{
            name   : 0x1::string::utf8(b"Background"),
            traits : v10,
        };
        0x1::vector::push_back<Feature>(&mut v9, v33);
        let v34 = Feature{
            name   : 0x1::string::utf8(b"Body"),
            traits : v12,
        };
        0x1::vector::push_back<Feature>(&mut v9, v34);
        let v35 = Feature{
            name   : 0x1::string::utf8(b"Decoration"),
            traits : v27,
        };
        0x1::vector::push_back<Feature>(&mut v9, v35);
        let v36 = Feature{
            name   : 0x1::string::utf8(b"Face"),
            traits : v19,
        };
        0x1::vector::push_back<Feature>(&mut v9, v36);
        let v37 = ContractInfo{
            id               : 0x2::object::new(arg1),
            owner_address    : 0x2::tx_context::sender(arg1),
            required_payment : 100000000000,
            count            : 0,
            nftsUsed         : v8,
            features         : v9,
        };
        0x2::transfer::share_object<ContractInfo>(v37);
    }

    public entry fun mint(arg0: &mut ContractInfo, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.required_payment;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v0, 0);
        let v1 = 0x2::table::new<0x1::string::String, 0x1::string::String>(arg3);
        let v2 = 0x2::tx_context::sender(arg3);
        mintInternal(v1, arg0, v0, arg1, arg2, v2, arg3);
    }

    public entry fun mintDiscount(arg0: &mut ContractInfo, arg1: &Whitelist, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.required_payment * (arg1.discountPct as u64) / 100;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v0, 0);
        let v1 = 0x2::table::new<0x1::string::String, 0x1::string::String>(arg4);
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut v1, arg1.key, arg1.value);
        let v2 = 0x2::tx_context::sender(arg4);
        mintInternal(v1, arg0, v0, arg2, arg3, v2, arg4);
    }

    fun mintInternal(arg0: 0x2::table::Table<0x1::string::String, 0x1::string::String>, arg1: &mut ContractInfo, arg2: u64, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.count < 50, 1);
        arg1.count = arg1.count + 1;
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut arg4, arg2, arg1.owner_address, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, arg5);
        let v0 = gen_next_free(0x1e5b3a72600891447fe46c506e31bdfed1704bcb188fe2240d4865a862e1e929::pseudorandom::rand_u32(arg6) % (50 as u32), arg1);
        let v1 = calc_traits(v0, arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<Feature>(&v1)) {
            let v3 = 0x1::vector::borrow<Feature>(&v1, v2);
            v2 = v2 + 1;
            0x2::table::add<0x1::string::String, 0x1::string::String>(&mut arg0, v3.name, 0x1::vector::borrow<Trait>(&v3.traits, 0).name);
        };
        let v4 = DisplayTrait{
            background : *0x2::table::borrow<0x1::string::String, 0x1::string::String>(&arg0, 0x1::string::utf8(b"Background")),
            body       : *0x2::table::borrow<0x1::string::String, 0x1::string::String>(&arg0, 0x1::string::utf8(b"Body")),
            decoration : *0x2::table::borrow<0x1::string::String, 0x1::string::String>(&arg0, 0x1::string::utf8(b"Decoration")),
            face       : *0x2::table::borrow<0x1::string::String, 0x1::string::String>(&arg0, 0x1::string::utf8(b"Face")),
        };
        let v5 = NFT{
            id            : 0x2::object::new(arg6),
            name          : arg3,
            nr            : convert((v0 as u16)),
            traits        : arg0,
            displayTraits : v4,
        };
        let v6 = NFTMinted{
            id        : 0x2::object::id<NFT>(&v5),
            minted_by : arg5,
        };
        0x2::event::emit<NFTMinted>(v6);
        0x2::transfer::public_transfer<NFT>(v5, arg5);
    }

    public fun pay_nft(arg0: &NFT) : &NFT {
        arg0
    }

    public entry fun remove_field(arg0: &CreatorCap, arg1: &mut 0x2::display::Display<NFT>, arg2: 0x1::string::String) {
        0x2::display::remove<NFT>(arg1, arg2);
    }

    public entry fun set_owner_address(arg0: &CreatorCap, arg1: &mut ContractInfo, arg2: address) {
        arg1.owner_address = arg2;
    }

    public entry fun set_required_payment(arg0: &CreatorCap, arg1: &mut ContractInfo, arg2: u64) {
        arg1.required_payment = arg2;
    }

    fun u32_to_vector_u8(arg0: u32) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 24;
        while (v1 >= 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 >> v1 & 255) as u8));
            if (v1 == 0) {
                break
            };
            v1 = v1 - 8;
        };
        v0
    }

    public fun whitelist(arg0: &Whitelist) : &Whitelist {
        arg0
    }

    // decompiled from Move bytecode v6
}

