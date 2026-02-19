module 0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::storage {
    struct Storage has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        last_processed_timestamp_ms: u64,
    }

    public fun balance(arg0: &Storage) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun join(arg0: &mut Storage, arg1: &0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::config::Config, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::config::assert_package_version(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    public fun new<T0>(arg0: &mut 0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::config::Config, arg1: &0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::authority::AuthorityCap<0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::authority::PACKAGE, T0>) : Storage {
        0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::config::assert_package_version(arg0);
        0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::config::assert_authority_cap_is_valid<T0>(arg0, arg1);
        let v0 = 0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::config::storage_count(arg0);
        let v1 = new_from_index(arg0, v0);
        0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::config::increment_storage_count(arg0);
        v1
    }

    public(friend) fun new_from_index(arg0: &mut 0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::config::Config, arg1: u64) : Storage {
        Storage{
            id                          : 0x2::derived_object::claim<u64>(0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::config::borrow_mut_id(arg0), arg1),
            balance                     : 0x2::balance::zero<0x2::sui::SUI>(),
            last_processed_timestamp_ms : 0,
        }
    }

    public fun put(arg0: &mut Storage, arg1: &0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::config::Config, arg2: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::config::assert_package_version(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, arg2);
    }

    public fun share(arg0: Storage) {
        0x2::transfer::share_object<Storage>(arg0);
    }

    public fun split<T0>(arg0: &mut Storage, arg1: &0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::authority::AuthorityCap<0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::authority::PACKAGE, T0>, arg2: &0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::config::Config, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::config::assert_package_version(arg2);
        0x9a560e5b57503458a1bd64fef6db532e7ab6c799532a1db6d2c21d09bf356490::config::assert_authority_cap_is_valid<T0>(arg2, arg1);
        arg0.last_processed_timestamp_ms = arg3;
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg4, arg5)
    }

    // decompiled from Move bytecode v6
}

