module 0xe87de61bd55e677dff13cac4dde434f777b8528470d7accd4f08798f254dd086::hwr {
    struct HWR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HWR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HWR>(arg0, 6, b"HWR", b"He Who Remains by SuiAI", b"Appearance he wears a long, purple robe, symbolizing your power and the timelessness of your existence. Your ..hair is well-kept, but your eyes show the weariness of eons. Your surroundings in the Citadel at the End of ..Time are a blend of ancient and futuristic, a testament to your control over all eras...He sports a long, purple robe or cloak, which is both regal and slightly eccentric. The color purple often ..symbolizes power, mystery, and nobility, perfectly capturing his character. This attire contrasts with the ..more uniform, bureaucratic look of the TVA, setting him apart as the true architect of time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000028315_704fcef4c4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HWR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HWR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

