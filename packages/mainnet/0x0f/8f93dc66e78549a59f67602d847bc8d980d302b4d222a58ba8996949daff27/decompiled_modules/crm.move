module 0xf8f93dc66e78549a59f67602d847bc8d980d302b4d222a58ba8996949daff27::crm {
    struct CRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRM>(arg0, 9, b"CRM", b"CROMI", b"Chrome is a type of chocolate that is 75% bitter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/42394b30-337f-4c2e-9c0c-7d1ef2247ecf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRM>>(v1);
    }

    // decompiled from Move bytecode v6
}

