module 0x8d8ffa1046acebaed531c764b2c4c73dc5179e9e6d8b40617021fa71644ea5d::manhattan {
    struct MANHATTAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANHATTAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANHATTAN>(arg0, 6, b"MANHATTAN", b"Doctor Manhattan on Sui", b"Doctor manhattan, the protector of Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ss_0380f816db.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANHATTAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANHATTAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

