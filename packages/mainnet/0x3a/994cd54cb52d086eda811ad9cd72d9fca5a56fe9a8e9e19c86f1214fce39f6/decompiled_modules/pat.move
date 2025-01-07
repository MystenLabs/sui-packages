module 0x3a994cd54cb52d086eda811ad9cd72d9fca5a56fe9a8e9e19c86f1214fce39f6::pat {
    struct PAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAT>(arg0, 6, b"PAT", b"Pat. Pepe's cat", b"Meet PAT. Hes Pepe's cat, and hes tired of living in his owners shadow. Now, hes stepping into the spotlight to make his own mark!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pt_GG_Mr_D4_400x400_0b1ad7c266.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

