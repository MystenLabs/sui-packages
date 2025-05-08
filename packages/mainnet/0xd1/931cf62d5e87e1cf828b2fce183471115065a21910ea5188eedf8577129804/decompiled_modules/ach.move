module 0xd1931cf62d5e87e1cf828b2fce183471115065a21910ea5188eedf8577129804::ach {
    struct ACH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACH>(arg0, 6, b"ACH", b"ASH CASH", b"ASH CASH making my mark on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigxi7eyac64sziyrq3vhwogky3wner3w5mjfr4a4hmfuxh4xtqwq4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ACH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

