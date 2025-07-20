module 0xcc5908cfe50545b694988c39220c49ca2b19099aff34349852de3063d1aaf676::djv {
    struct DJV has drop {
        dummy_field: bool,
    }

    fun init(arg0: DJV, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DJV>(arg0, 6, b"DJV", b"DEJAVU", b"Launch a project on @suilaunchcoin by tagging @sniperdejavu and including the project name and logo. $DJV + DEJAVU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/djv-jb5u20.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DJV>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DJV>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

