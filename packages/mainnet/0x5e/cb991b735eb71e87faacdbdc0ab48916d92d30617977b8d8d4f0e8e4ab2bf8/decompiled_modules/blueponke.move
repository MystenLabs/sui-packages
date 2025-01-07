module 0x5ecb991b735eb71e87faacdbdc0ab48916d92d30617977b8d8d4f0e8e4ab2bf8::blueponke {
    struct BLUEPONKE has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BLUEPONKE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BLUEPONKE>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BLUEPONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BLUEPONKE>(arg0, 9, b"BluePonke", b"Blue Ponke", b"Blue Ponke Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BLUEPONKE>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUEPONKE>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEPONKE>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BLUEPONKE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BLUEPONKE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BLUEPONKE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

