module 0x248ff51ea83d904168da386077aa60dec69a8692479cd245d661391604838ce8::witch {
    struct WITCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WITCH>(arg0, 6, b"WITCH", b"WIitchdogSui", b"Witch dog will bewitch and take a big part in the world of cryptocurrency", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001114_86b0c70c23.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WITCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WITCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

