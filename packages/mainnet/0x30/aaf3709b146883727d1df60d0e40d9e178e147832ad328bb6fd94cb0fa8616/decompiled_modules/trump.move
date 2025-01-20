module 0x30aaf3709b146883727d1df60d0e40d9e178e147832ad328bb6fd94cb0fa8616::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 9, b"TRUMP", b"Trump", x"546865204e4557204f6666696369616c205472756d70204d656d65206973204845524521204974e28099732074696d6520746f2063656c6562726174652065766572797468696e67207765207374616e6420666f723a2057494e4e494e4721204a6f696e207468652076657279207370656369616c205472756d7020436f6d6d756e6974792e2047455420594f555220245452554d50204e4f572e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bf82ae4a-ccbc-4705-89cb-526d9d003829.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

