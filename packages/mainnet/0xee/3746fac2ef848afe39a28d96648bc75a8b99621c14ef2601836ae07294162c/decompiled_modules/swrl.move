module 0xee3746fac2ef848afe39a28d96648bc75a8b99621c14ef2601836ae07294162c::swrl {
    struct SWRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWRL>(arg0, 9, b"SWRL", b"SuiWorld", b"Sui World proyect", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkwz9sAJKnseB7OUYmFpD1D_VpiNd5p5KNUpAQAp4-WQGclkFB1NRetGnMGmdhDMHprzc&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SWRL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWRL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

