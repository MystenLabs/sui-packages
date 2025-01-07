module 0x2d3a6a4bb5169b36aa2c02ffa61f56ed03ebd7bbd014e8c0d06035193acf2b35::suuui {
    struct SUUUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUUUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUUUI>(arg0, 6, b"SUUUI", b"HarryPotterGuiIusObama10InuWifHat", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b" ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUUUI>(&mut v2, 55555555000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUUUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUUUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

