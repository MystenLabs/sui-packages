module 0x37ef86b94657fed64856c20c8c9a5c66338c71ab5c9fe5c768842eccd8857558::mag {
    struct MAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAG>(arg0, 6, b"Mag", b"Magic Conch Ai", x"41736b2061207175657374696f6e2c20616e64206c657420746865204d6167696320436f6e63682041492064656369646520796f757220666174652e20576973646f6d3f204c75636b3f204f72206e6f6e73656e73653f2054686572652773206f6e6c79206f6e652077617920746f2066696e64206f75742e0a68747470733a2f2f782e636f6d2f4d61676963436f6e63685f4149", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736459331592.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

