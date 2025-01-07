module 0xe9d3da86dfa9c4f7193483e645cc66d4ca77d3d9dbdc93c444ff8f041dee4f41::pashacat {
    struct PASHACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PASHACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PASHACAT>(arg0, 9, b"PASHACAT", b"PASHA", b"Awesome cat that i've ever seen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7b7ef6df-9583-450d-83bf-d4a5a141870e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PASHACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PASHACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

