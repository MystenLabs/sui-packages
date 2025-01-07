module 0x6047fc4984e0aa388e1bd17c0382553e8b69ea38204c580168bb75e3f5062594::ww3 {
    struct WW3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WW3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WW3>(arg0, 6, b"WW3", b"Worldwar on Sui", b"$WW3 is set to be the fix-it-all solution. Ready to see where you stand in this wild world? Catch you soon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo1_a731182ab8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WW3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WW3>>(v1);
    }

    // decompiled from Move bytecode v6
}

