module 0xebff24806ea226dfecf36af1f16e3678551e59375c74899c0bcbe8622d66e5fa::grinch {
    struct GRINCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRINCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRINCH>(arg0, 6, b"Grinch", b"Grinch On SUI", x"4a6f696e20546865204772696e6368204f6e20536f6c616e612041726d79200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/h6_Pfeflw_400x400_9d498f686e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRINCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRINCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

