module 0x661d851eb1fbfc9e4c5acf42c18e1d45db3e132bb0ad5851ce5c562bd20183a5::koto {
    struct KOTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOTO>(arg0, 6, b"Koto", b"kotopia", x"6b6f746f7069612066726f6d20746865206675747572652074616b6520746865206b6f746f706961202070696c6c0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Q5hh_S7_DX_400x400_1_c82757934e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

