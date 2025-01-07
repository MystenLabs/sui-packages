module 0x523c39e13554b92c98c7b6fda5baa03a4d4d32a12c134534b74e0bc164afd48b::hob {
    struct HOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOB>(arg0, 9, b"HOB", b"Hobbit ", b"\"Some believe that it is only great power that can hold evil in check. But that is not what I have found. I have found that it is the small things, everyday deeds of ordinary folk, that keep the darkness at bay... simple acts of kindness and love.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0dafe6eb-2b66-4547-a1a9-6bd7ac061a5d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

