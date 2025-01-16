module 0x679cee9f899b3a7dc940fe0a1ec4c5edb0e3b15bbd459cb5ff1f32975246caf::cwcy {
    struct CWCY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWCY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CWCY>(arg0, 6, b"CWCY", b"cooking with kya by SuiAI", x"436f6f6b696e672057697468204b79612028435743592920697320616e204149204167656e7420636f6d70616e696f6e207468617420646973686573207570206d6f7574687761746572696e6720726563697065732c2067756964657320796f75207468726f75676820657665727920636f6f6b696e67206368616c6c656e67652c20616e642061646170747320746f20796f757220736b696c6c206c6576656ce280947768657468657220796f75e28099726520776869736b696e67207570206120717569636b20736e61636b206f722062616b696e672061206c61766973682066656173742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/cooking_with_kya_83defc4e36.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CWCY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CWCY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

