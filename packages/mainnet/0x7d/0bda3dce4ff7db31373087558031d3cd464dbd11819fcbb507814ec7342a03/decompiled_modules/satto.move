module 0x7d0bda3dce4ff7db31373087558031d3cd464dbd11819fcbb507814ec7342a03::satto {
    struct SATTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATTO>(arg0, 6, b"SATTO", b"Satto Sui", b"10,000 NFT collection living on $Sui powered by $PUNK token, created by ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/unnamed_2_e1620a9997.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SATTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

