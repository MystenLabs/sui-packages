module 0x38fff61f06a34542eee638d29b7e7c4d8d0612ddcadfbfb01fb3c2af54cf9326::ius {
    struct IUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IUS>(arg0, 9, b"IUS", b"Suiius ", b"Token : IUS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/33162efa-61cd-4c7d-bf77-b257bfa6469f-CA02A13E-7ED9-447D-B0CB-28DC985826AD.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

