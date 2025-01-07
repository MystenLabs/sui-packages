module 0xedcb08865d976b8bd91a3f15439fe598533f2a8daabd7c26796f527e9599fd7c::time {
    struct TIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIME>(arg0, 9, b"TIME", b"Watch", b"Time of Crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/194bf2d8-13bc-40f6-b9d8-69454d9d2eb1-1000022991.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIME>>(v1);
    }

    // decompiled from Move bytecode v6
}

