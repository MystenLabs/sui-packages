module 0x86ec47b26356cdf8e65bc6c59253a8c1f9e07702eac5494f3f15421cd36ee6c2::ocat {
    struct OCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCAT>(arg0, 6, b"OCAT", b"Octocat", b"$Ocat Octocat is GitHub's official mascot, a playful and iconic figure that has become synonymous with the platform now on $Sui Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014790_63eb491d9a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

