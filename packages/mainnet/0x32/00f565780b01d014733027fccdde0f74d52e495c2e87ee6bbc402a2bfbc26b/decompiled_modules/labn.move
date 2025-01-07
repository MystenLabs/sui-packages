module 0x3200f565780b01d014733027fccdde0f74d52e495c2e87ee6bbc402a2bfbc26b::labn {
    struct LABN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LABN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LABN>(arg0, 9, b"LABN", b"LABOON", x"41206769616e74207768616c652077697468206d616e792073636172732066726f6d20656e647572696e6720636f756e746c657373206661696c757265732e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a0d42e2f-ce8d-4572-be1a-8ffbb22b6b41.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LABN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LABN>>(v1);
    }

    // decompiled from Move bytecode v6
}

