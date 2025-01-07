module 0x111f717a325739bcd295c6740317a4d3f06f635830b9417ad7745e2449f0b562::spc {
    struct SPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPC>(arg0, 6, b"SPC", b"Space Penguins", b"$SPC Space Penguins ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5m3vg_L_Az_400x400_1848231746.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPC>>(v1);
    }

    // decompiled from Move bytecode v6
}

