module 0x27b01dfb8307602e8fd0429415e06a3279bc80eab9e0ee603c0987bf37ed038c::claim {
    struct Mapping has store, key {
        id: 0x2::object::UID,
        owner: address,
        map: 0x2::vec_map::VecMap<address, 0xaff4cbee017a9f2faf82ba716df8c2ca1172f235a4e70a5207302f0798b756e9::jellyfish::NFT>,
    }

    struct CreatorCap has key {
        id: 0x2::object::UID,
    }

    struct CLAIM has drop {
        dummy_field: bool,
    }

    public entry fun claim(arg0: &mut Mapping, arg1: &0x2::transfer_policy::TransferPolicy<0xaff4cbee017a9f2faf82ba716df8c2ca1172f235a4e70a5207302f0798b756e9::jellyfish::NFT>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let (_, v2) = 0x2::vec_map::remove<address, 0xaff4cbee017a9f2faf82ba716df8c2ca1172f235a4e70a5207302f0798b756e9::jellyfish::NFT>(&mut arg0.map, &v0);
        0x2::kiosk::lock<0xaff4cbee017a9f2faf82ba716df8c2ca1172f235a4e70a5207302f0798b756e9::jellyfish::NFT>(arg2, arg3, arg1, v2);
    }

    public entry fun add_map(arg0: &CreatorCap, arg1: &mut Mapping, arg2: address, arg3: 0xaff4cbee017a9f2faf82ba716df8c2ca1172f235a4e70a5207302f0798b756e9::jellyfish::NFT) {
        0x2::vec_map::insert<address, 0xaff4cbee017a9f2faf82ba716df8c2ca1172f235a4e70a5207302f0798b756e9::jellyfish::NFT>(&mut arg1.map, arg2, arg3);
    }

    fun init(arg0: CLAIM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CreatorCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<CreatorCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = Mapping{
            id    : 0x2::object::new(arg1),
            owner : 0x2::tx_context::sender(arg1),
            map   : 0x2::vec_map::empty<address, 0xaff4cbee017a9f2faf82ba716df8c2ca1172f235a4e70a5207302f0798b756e9::jellyfish::NFT>(),
        };
        0x2::transfer::share_object<Mapping>(v1);
    }

    public entry fun remove_map(arg0: &CreatorCap, arg1: &mut Mapping, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let (_, v1) = 0x2::vec_map::remove<address, 0xaff4cbee017a9f2faf82ba716df8c2ca1172f235a4e70a5207302f0798b756e9::jellyfish::NFT>(&mut arg1.map, &arg2);
        0x2::transfer::public_transfer<0xaff4cbee017a9f2faf82ba716df8c2ca1172f235a4e70a5207302f0798b756e9::jellyfish::NFT>(v1, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

