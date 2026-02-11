module 0x6820bb600eb1bcb105cc9a8ff271c27caad82e65fc1012d1ccad1febb598d1d4::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6820bb600eb1bcb105cc9a8ff271c27caad82e65fc1012d1ccad1febb598d1d4::config::new<INIT>(&arg0, arg1);
        0x6820bb600eb1bcb105cc9a8ff271c27caad82e65fc1012d1ccad1febb598d1d4::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0x6820bb600eb1bcb105cc9a8ff271c27caad82e65fc1012d1ccad1febb598d1d4::config::borrow_mut_id(&mut v0), arg1);
        let v1 = 0;
        while (v1 < 0x6820bb600eb1bcb105cc9a8ff271c27caad82e65fc1012d1ccad1febb598d1d4::config::storage_count(&v0)) {
            0x6820bb600eb1bcb105cc9a8ff271c27caad82e65fc1012d1ccad1febb598d1d4::storage::share(0x6820bb600eb1bcb105cc9a8ff271c27caad82e65fc1012d1ccad1febb598d1d4::storage::new_from_index(&mut v0, v1));
            v1 = v1 + 1;
        };
        0x6820bb600eb1bcb105cc9a8ff271c27caad82e65fc1012d1ccad1febb598d1d4::config::share(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

