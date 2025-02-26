module 0x32cb6a38ce13fd6cb44844820b23f9c61465d5702f82b9f76bc533e7f3f50d85::vortex {
    struct VORTEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: VORTEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VORTEX>(arg0, 6, b"VORTEX", b"Vortex AI", x"564f525445582054686520446563656e7472616c6973656420446174612073746f726167652e2041636365737320796f75722066696c6573207365637572656c79207769746820796f75722077616c6c65742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1740537948805.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VORTEX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VORTEX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

