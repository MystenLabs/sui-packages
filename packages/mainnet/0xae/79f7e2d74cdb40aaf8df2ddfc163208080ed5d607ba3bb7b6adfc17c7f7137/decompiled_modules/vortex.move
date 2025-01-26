module 0xae79f7e2d74cdb40aaf8df2ddfc163208080ed5d607ba3bb7b6adfc17c7f7137::vortex {
    struct VORTEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: VORTEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VORTEX>(arg0, 6, b"VORTEX", b"Vortex AI", x"564f52544558c2a054686520446563656e7472616c6973656420446174612073746f726167652e2041636365737320796f75722066696c6573207365637572656c79207769746820796f75722077616c6c65742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737856713143.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VORTEX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VORTEX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

