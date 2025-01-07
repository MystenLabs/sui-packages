module 0x34d083c1a8de92fc5dc7e3fa9f228eb859e618f2b0f22a4f2372370e97581d4f::crm {
    struct CRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRM>(arg0, 9, b"CRM", b"CROMI", b"Chrome is a type of chocolate that is 75% bitter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d8528f64-4cda-4fed-9873-2b3008fe786b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRM>>(v1);
    }

    // decompiled from Move bytecode v6
}

