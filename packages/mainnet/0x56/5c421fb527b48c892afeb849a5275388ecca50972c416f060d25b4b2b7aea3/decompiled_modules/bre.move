module 0x565c421fb527b48c892afeb849a5275388ecca50972c416f060d25b4b2b7aea3::bre {
    struct BRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRE>(arg0, 9, b"BRE", b"Brekele", b"Brekele (curly), not just hair type,its a lifestyle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eafea599-5981-4c6a-819f-33204040b5f4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRE>>(v1);
    }

    // decompiled from Move bytecode v6
}

