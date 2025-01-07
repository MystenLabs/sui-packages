module 0xeb09ef4a8408ce12837d2784007fe53cedbf3839973ae00b4fa03afd80d1d42::ptardio {
    struct PTARDIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTARDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTARDIO>(arg0, 6, b"PTARDIO", b"TRUMPTARDIO", b"TRUMPTARDIO CTO! Lets rekt f dev", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ro7_Tk5s_S_400x400_a405125850.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTARDIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PTARDIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

