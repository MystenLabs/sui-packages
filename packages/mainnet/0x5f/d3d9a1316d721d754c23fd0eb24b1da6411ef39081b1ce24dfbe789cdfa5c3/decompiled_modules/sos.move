module 0x5fd3d9a1316d721d754c23fd0eb24b1da6411ef39081b1ce24dfbe789cdfa5c3::sos {
    struct SOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOS>(arg0, 6, b"SOS", b"SOGIE THE SAUSAGE IN SUI", b"$SOS - just a silly sausage on $SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicrmnonbbu3jprt346fwndbltljkz4yz4neiybsa5g4ar55vzhmlq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SOS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

