module 0x9fc7436ebb27e783de16095fb59af985f43521c94452bec72ffcf352a0967c34::doke {
    struct DOKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOKE>(arg0, 6, b"DOKE", b"Doge Sake", x"596f7520736b697070656420244e6569726f206f6e204554480a596f7520736b6970706564202447696761206f6e20536f6c0a596f7520736b697070656420244272657474206f6e20426173650a596f7520736b69707065642024446f67206f6e2052756e65730a4f6e205375692c20646f206e6f7420736b69702024444f4b45", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000121212_a510e1e408.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

