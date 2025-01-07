module 0x9a200f796d424e4774b3ad5e18d9fdbe505ae72b19c2b9a6bb158e4343c30dc::t1 {
    struct T1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T1>(arg0, 9, b"T1", b"T1 ", b"T1 Champion 2024", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d4d7b2cb-5829-4b55-8b97-6cac618fc872.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T1>>(v1);
    }

    // decompiled from Move bytecode v6
}

