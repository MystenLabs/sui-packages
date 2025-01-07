module 0xaac8e0146d4b32b9357df5ea7663552528c4ecae8e6422d827602a62a391aa5a::adam {
    struct ADAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADAM>(arg0, 6, b"ADAM", b"ADAM BUNNY", b"$ADAM the blue rabbit, is ready to turn up the chaos on Sui. The money printer is a maniac! BRRRRRR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_3u_Hbo_XQAAD_Kl_23657622d2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

