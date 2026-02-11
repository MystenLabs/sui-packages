module 0x6820bb600eb1bcb105cc9a8ff271c27caad82e65fc1012d1ccad1febb598d1d4::storage {
    struct Storage has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun balance(arg0: &Storage) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun join(arg0: &mut Storage, arg1: &0x6820bb600eb1bcb105cc9a8ff271c27caad82e65fc1012d1ccad1febb598d1d4::config::Config, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x6820bb600eb1bcb105cc9a8ff271c27caad82e65fc1012d1ccad1febb598d1d4::config::assert_package_version(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    public fun new<T0>(arg0: &mut 0x6820bb600eb1bcb105cc9a8ff271c27caad82e65fc1012d1ccad1febb598d1d4::config::Config, arg1: &0x6820bb600eb1bcb105cc9a8ff271c27caad82e65fc1012d1ccad1febb598d1d4::authority::AuthorityCap<0x6820bb600eb1bcb105cc9a8ff271c27caad82e65fc1012d1ccad1febb598d1d4::authority::PACKAGE, T0>) : Storage {
        0x6820bb600eb1bcb105cc9a8ff271c27caad82e65fc1012d1ccad1febb598d1d4::config::assert_package_version(arg0);
        0x6820bb600eb1bcb105cc9a8ff271c27caad82e65fc1012d1ccad1febb598d1d4::config::assert_authority_cap_is_valid<T0>(arg0, arg1);
        let v0 = 0x6820bb600eb1bcb105cc9a8ff271c27caad82e65fc1012d1ccad1febb598d1d4::config::storage_count(arg0);
        let v1 = new_from_index(arg0, v0);
        0x6820bb600eb1bcb105cc9a8ff271c27caad82e65fc1012d1ccad1febb598d1d4::config::increment_storage_count(arg0);
        v1
    }

    public(friend) fun new_from_index(arg0: &mut 0x6820bb600eb1bcb105cc9a8ff271c27caad82e65fc1012d1ccad1febb598d1d4::config::Config, arg1: u64) : Storage {
        Storage{
            id      : 0x2::derived_object::claim<u64>(0x6820bb600eb1bcb105cc9a8ff271c27caad82e65fc1012d1ccad1febb598d1d4::config::borrow_mut_id(arg0), arg1),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        }
    }

    public fun put(arg0: &mut Storage, arg1: &0x6820bb600eb1bcb105cc9a8ff271c27caad82e65fc1012d1ccad1febb598d1d4::config::Config, arg2: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x6820bb600eb1bcb105cc9a8ff271c27caad82e65fc1012d1ccad1febb598d1d4::config::assert_package_version(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, arg2);
    }

    public fun share(arg0: Storage) {
        0x2::transfer::share_object<Storage>(arg0);
    }

    public fun split<T0>(arg0: &mut Storage, arg1: &0x6820bb600eb1bcb105cc9a8ff271c27caad82e65fc1012d1ccad1febb598d1d4::authority::AuthorityCap<0x6820bb600eb1bcb105cc9a8ff271c27caad82e65fc1012d1ccad1febb598d1d4::authority::PACKAGE, T0>, arg2: &0x6820bb600eb1bcb105cc9a8ff271c27caad82e65fc1012d1ccad1febb598d1d4::config::Config, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x6820bb600eb1bcb105cc9a8ff271c27caad82e65fc1012d1ccad1febb598d1d4::config::assert_package_version(arg2);
        0x6820bb600eb1bcb105cc9a8ff271c27caad82e65fc1012d1ccad1febb598d1d4::config::assert_authority_cap_is_valid<T0>(arg2, arg1);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

