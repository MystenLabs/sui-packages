module 0x13633deeaead9108ec10696a77745b9a78df5c1e80789a5a6440a388ed65603a::tm878 {
    struct TM878 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TM878, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TM878>(arg0, 9, b"TM878", b"TM", b"Token for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1da72736-eb76-4a43-9249-e928d90b8ec2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TM878>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TM878>>(v1);
    }

    // decompiled from Move bytecode v6
}

