module 0x65a3936dde0ab92c05872e0f7b513e219e6873f55f6937b9f02ee0e51a30cd3::blub {
    struct BLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUB>(arg0, 6, b"BLUB", b"blubia Sui", b"$BLUBIA is $BLUB's Wife and the reigning QUEEN of the SUI OCEAN!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blubia_ec2722d7d4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

