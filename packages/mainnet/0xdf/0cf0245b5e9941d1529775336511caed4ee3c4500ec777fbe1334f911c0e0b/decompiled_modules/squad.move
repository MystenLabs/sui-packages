module 0xdf0cf0245b5e9941d1529775336511caed4ee3c4500ec777fbe1334f911c0e0b::squad {
    struct SQUAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUAD>(arg0, 6, b"$SQUAD", b"SUI-CIDE SQUAD", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://sui-cidesquad.com/img/squad-logo-256.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQUAD>>(v1);
        0x2::coin::mint_and_transfer<SQUAD>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUAD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

