module 0xde959fd4172d99f62e0394daf0436fd6e1fbc8b1574c1ceb39b97f36d7884845::wlc {
    struct WLC has drop {
        dummy_field: bool,
    }

    struct InitEvent has copy, drop {
        cap_id: 0x2::object::ID,
        metadata_id: 0x2::object::ID,
    }

    fun init(arg0: WLC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLC>(arg0, 6, b"WLC", b"WorldLove Coin", b"A community meme coin created for decentralization, peace and love.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://agvupjyylqqcnkegj4zfrwtx4x7m6gvkdgqdcefv2fxfl5zqkubq.arweave.net/AatHpxhcICaohk8yWNp35f7PGqoZoDEQtdFuVfcwVQM")), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WLC>>(v2);
        0x2::coin::mint_and_transfer<WLC>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WLC>>(v3);
        let v4 = InitEvent{
            cap_id      : 0x2::object::id<0x2::coin::TreasuryCap<WLC>>(&v3),
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<WLC>>(&v2),
        };
        0x2::event::emit<InitEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

