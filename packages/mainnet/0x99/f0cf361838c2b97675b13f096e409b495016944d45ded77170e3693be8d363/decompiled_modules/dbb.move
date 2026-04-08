module 0x99f0cf361838c2b97675b13f096e409b495016944d45ded77170e3693be8d363::dbb {
    struct DBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBB>(arg0, 6, b"DBB", b"The Daily Buyback", b"Coffee Lovers Club. Membership requirement: skip one coffee. Buy DBB instead. Repeat every day. No exceptions. No end date. Just the ritual.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1775624338986.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DBB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

