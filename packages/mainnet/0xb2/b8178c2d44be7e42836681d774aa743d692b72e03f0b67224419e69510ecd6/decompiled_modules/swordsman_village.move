module 0x40eccc7f6302e74de80f905fe80d3caedd008209a3a503b567be02161248c13d::swordsman_village {
    struct SwordsmanVillage has drop {
        dummy_field: bool,
    }

    public fun pirate_kind() : u8 {
        1
    }

    public fun recurit(arg0: &0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_world::KapyWorld, arg1: &mut 0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_crew::KapyCrew, arg2: 0x40eccc7f6302e74de80f905fe80d3caedd008209a3a503b567be02161248c13d::foundry::Sword, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = SwordsmanVillage{dummy_field: false};
        let v1 = 0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_pirate::new<SwordsmanVillage>(arg0, pirate_kind(), v0, arg3);
        let v2 = 0x2::object::id<0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_pirate::KapyPirate>(&v1);
        0x2::transfer::public_transfer<0x40eccc7f6302e74de80f905fe80d3caedd008209a3a503b567be02161248c13d::foundry::Sword>(arg2, 0x2::object::id_to_address(&v2));
        0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_crew::recruit(arg1, v1);
    }

    // decompiled from Move bytecode v6
}

