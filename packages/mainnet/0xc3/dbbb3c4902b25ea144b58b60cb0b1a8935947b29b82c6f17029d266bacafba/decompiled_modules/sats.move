module 0xc3dbbb3c4902b25ea144b58b60cb0b1a8935947b29b82c6f17029d266bacafba::sats {
    struct SATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATS>(arg0, 0, b"SATS", b"SATS", b"SATS Create by bitsui.io", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cloudflare-ipfs.com/ipfs/Qmab1RmVueZXfbtQts1QmYhKYMuGzJ7otBmb2CFh4tukXM")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SATS>>(v1);
        0x2::coin::mint_and_transfer<SATS>(&mut v2, 2100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SATS>>(v2);
    }

    // decompiled from Move bytecode v6
}

