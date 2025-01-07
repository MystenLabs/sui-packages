module 0x743864bc546dc5d19ea6c0cf2694a125f22d953339866dc107e194328fbd674b::rooster {
    struct ROOSTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROOSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROOSTER>(arg0, 9, b"Rooster", b"Roost", b"Official.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/fe02f51932782b3be5d81df5623a6f08blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROOSTER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROOSTER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

