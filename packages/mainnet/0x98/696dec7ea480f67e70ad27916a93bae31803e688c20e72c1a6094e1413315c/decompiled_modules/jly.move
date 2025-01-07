module 0x98696dec7ea480f67e70ad27916a93bae31803e688c20e72c1a6094e1413315c::jly {
    struct JLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JLY>(arg0, 9, b"JLY", b"Jelly ", b"Jelly are the cutest animals in the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7cf4ed84-9a71-43d3-8a19-2a1ae1bc36e5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

