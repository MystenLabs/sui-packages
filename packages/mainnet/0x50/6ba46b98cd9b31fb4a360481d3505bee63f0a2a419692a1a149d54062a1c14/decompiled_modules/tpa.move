module 0x506ba46b98cd9b31fb4a360481d3505bee63f0a2a419692a1a149d54062a1c14::tpa {
    struct TPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPA>(arg0, 6, b"TPA", b"TRUMP PRESIDENT AGAIN", b"TPA is a PolitiFi Base memecoin that aims to capture the patriotic vision of the president of the United States, Donald Trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003020_b76093e89f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

