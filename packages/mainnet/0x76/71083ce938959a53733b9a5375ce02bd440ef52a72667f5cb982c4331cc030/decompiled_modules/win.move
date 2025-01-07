module 0x7671083ce938959a53733b9a5375ce02bd440ef52a72667f5cb982c4331cc030::win {
    struct WIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIN>(arg0, 6, b"WIN", b"WINNER", x"4c6574732063656c6562726174652e200a5472756d70206173203437746820707265736964656e74206f66205553412e20536f6369616c7320736f6f6e200a4a6f696e207467", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8281_9d0922df0d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

