module 0xe2e09de9230afa80d228b92b07d16900986740a08b98a590a9811ef710ad5de6::leds {
    struct LEDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEDS>(arg0, 6, b"Leds", b"MadLeds", x"2441524d454e492069732061206d65646c656420636f6d6d756e657474652074616b656f7665722e20464f434b204554210a0a285765277265206120636f72652067726f7570206f66206561726c79204d6164204c616420686f6c646572732077686f2076656e74757265206f757420746f20646973636f7665722070726f6d6973696e67207465636820696e20576562203320776f726c642e20535549206973206e657874292050726f6a656374206973203130302520636f6d6d756e697479206f776e656420616e642077652064657676767676", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cn_W_Rb_QVJ_400x400_57187cf60b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

