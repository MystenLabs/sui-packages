module 0x1dba6e04bcdbe361895503eda90b4d6d8a5a362e1d79e0b95ea0b206812c1985::maga {
    struct MAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGA>(arg0, 6, b"MAGA", b"TRIUMPH", b"$MAGA takes the race to the next level with Trump riding a stunning 18k gold Triumph motorcycle. This luxurious, golden beast represents not just power and speed, but wealth, success, and the unstoppable pursuit of greatness. With every twist of the throttle, Trump's golden ride shines bright, leaving a trail of awe and ambition in its wake. $MAGA is more than a tokenit's a golden ticket to ride alongside a leader driven by the desire to win. Buckle up and join the fast lane to victory with $MAGA on an 18k gold Triumph!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_49_dfa3c0faeb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

