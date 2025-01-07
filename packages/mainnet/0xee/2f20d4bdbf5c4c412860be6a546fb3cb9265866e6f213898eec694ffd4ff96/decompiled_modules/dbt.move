module 0xee2f20d4bdbf5c4c412860be6a546fb3cb9265866e6f213898eec694ffd4ff96::dbt {
    struct DBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBT>(arg0, 6, b"Dbt", b"Diabet ", b"I am the father of a wonderful 13-year-old girl who has been battling diabetes every day. I do not have the financial means to buy an insulin pump as needed. It costs 5200 euros. We created this Token in the hope that we can collect these pennies fro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733079078163.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DBT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

