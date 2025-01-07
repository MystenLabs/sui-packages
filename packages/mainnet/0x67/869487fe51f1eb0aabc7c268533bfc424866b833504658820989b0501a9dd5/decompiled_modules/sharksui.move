module 0x67869487fe51f1eb0aabc7c268533bfc424866b833504658820989b0501a9dd5::sharksui {
    struct SHARKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKSUI>(arg0, 6, b"SHARKSUI", b"SHARKYBOI", x"534841524b592049732061206a6565746e69766f726f7573206269670a666973682077697468206120646565702073746f6d6163680a6f6e2074686520535549204e4554574f524b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Zl_Phq_O_Rg_400x400_6350007434.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

