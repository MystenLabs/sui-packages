module 0x7d04ad000fe89af5fa4346ff3436cd3f281cef3e5e4dd1e6c745809d822c407::war3 {
    struct WAR3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAR3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAR3>(arg0, 9, b"WAR3", b"WAR3TOKEN", b"Prepare for the End Times", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4b92520a-4c68-4fec-9f06-41de8726fcdc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAR3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAR3>>(v1);
    }

    // decompiled from Move bytecode v6
}

