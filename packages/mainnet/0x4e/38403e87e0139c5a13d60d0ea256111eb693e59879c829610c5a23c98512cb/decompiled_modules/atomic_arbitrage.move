module 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::atomic_arbitrage {
    entry fun arb_aftermath_bluefin<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_aftermath::Pool<T0, T1>, arg2: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_bluefin::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 2);
        let v1 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_aftermath::swap_a_to_b<T0, T1>(arg1, arg0, v0, 0, arg4, arg5);
        let v2 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_bluefin::swap_b_to_a<T0, T1>(arg2, v1, 0x2::coin::value<T1>(&v1), 0, arg4, arg5);
        assert!(0x2::coin::value<T0>(&v2) >= arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg5));
    }

    entry fun arb_aftermath_cetus<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_aftermath::Pool<T0, T1>, arg2: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_cetus::Pool<T0, T1>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 2);
        let v1 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_aftermath::swap_a_to_b<T0, T1>(arg1, arg0, v0, 0, arg5, arg6);
        let v2 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_cetus::swap_b_to_a<T0, T1>(arg2, v1, 0x2::coin::value<T1>(&v1), 0, arg4, arg5, arg6);
        assert!(0x2::coin::value<T0>(&v2) >= arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    entry fun arb_aftermath_deepbook<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_aftermath::Pool<T0, T1>, arg2: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_deepbook::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 2);
        let v1 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_aftermath::swap_a_to_b<T0, T1>(arg1, arg0, v0, 0, arg4, arg5);
        let v2 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_deepbook::swap_b_to_a<T0, T1>(arg2, v1, 0x2::coin::value<T1>(&v1), 0, arg4, arg5);
        assert!(0x2::coin::value<T0>(&v2) >= arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg5));
    }

    entry fun arb_aftermath_kriya<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_aftermath::Pool<T0, T1>, arg2: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_kriya::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 2);
        let v1 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_aftermath::swap_a_to_b<T0, T1>(arg1, arg0, v0, 0, arg4, arg5);
        let v2 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_kriya::swap_b_to_a<T0, T1>(arg2, v1, 0x2::coin::value<T1>(&v1), 0, arg4, arg5);
        assert!(0x2::coin::value<T0>(&v2) >= arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg5));
    }

    entry fun arb_aftermath_turbos<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_aftermath::Pool<T0, T1>, arg2: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_turbos::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 2);
        let v1 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_aftermath::swap_a_to_b<T0, T1>(arg1, arg0, v0, 0, arg4, arg5);
        let v2 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_turbos::swap_b_to_a<T0, T1>(arg2, v1, 0x2::coin::value<T1>(&v1), 0, arg4, arg5);
        assert!(0x2::coin::value<T0>(&v2) >= arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg5));
    }

    entry fun arb_bluefin_aftermath<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_bluefin::Pool<T0, T1>, arg2: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_aftermath::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 2);
        let v1 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_bluefin::swap_a_to_b<T0, T1>(arg1, arg0, v0, 0, arg4, arg5);
        let v2 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_aftermath::swap_b_to_a<T0, T1>(arg2, v1, 0x2::coin::value<T1>(&v1), 0, arg4, arg5);
        assert!(0x2::coin::value<T0>(&v2) >= arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg5));
    }

    entry fun arb_bluefin_cetus<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_bluefin::Pool<T0, T1>, arg2: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_cetus::Pool<T0, T1>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 2);
        let v1 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_bluefin::swap_a_to_b<T0, T1>(arg1, arg0, v0, 0, arg5, arg6);
        let v2 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_cetus::swap_b_to_a<T0, T1>(arg2, v1, 0x2::coin::value<T1>(&v1), 0, arg4, arg5, arg6);
        assert!(0x2::coin::value<T0>(&v2) >= arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    entry fun arb_bluefin_deepbook<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_bluefin::Pool<T0, T1>, arg2: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_deepbook::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 2);
        let v1 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_bluefin::swap_a_to_b<T0, T1>(arg1, arg0, v0, 0, arg4, arg5);
        let v2 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_deepbook::swap_b_to_a<T0, T1>(arg2, v1, 0x2::coin::value<T1>(&v1), 0, arg4, arg5);
        assert!(0x2::coin::value<T0>(&v2) >= arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg5));
    }

    entry fun arb_bluefin_kriya<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_bluefin::Pool<T0, T1>, arg2: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_kriya::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 2);
        let v1 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_bluefin::swap_a_to_b<T0, T1>(arg1, arg0, v0, 0, arg4, arg5);
        let v2 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_kriya::swap_b_to_a<T0, T1>(arg2, v1, 0x2::coin::value<T1>(&v1), 0, arg4, arg5);
        assert!(0x2::coin::value<T0>(&v2) >= arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg5));
    }

    entry fun arb_bluefin_turbos<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_bluefin::Pool<T0, T1>, arg2: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_turbos::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 2);
        let v1 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_bluefin::swap_a_to_b<T0, T1>(arg1, arg0, v0, 0, arg4, arg5);
        let v2 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_turbos::swap_b_to_a<T0, T1>(arg2, v1, 0x2::coin::value<T1>(&v1), 0, arg4, arg5);
        assert!(0x2::coin::value<T0>(&v2) >= arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg5));
    }

    entry fun arb_cetus_aftermath<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_cetus::Pool<T0, T1>, arg2: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_aftermath::Pool<T0, T1>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 2);
        let v1 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_cetus::swap_a_to_b<T0, T1>(arg1, arg0, v0, 0, arg4, arg5, arg6);
        let v2 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_aftermath::swap_b_to_a<T0, T1>(arg2, v1, 0x2::coin::value<T1>(&v1), 0, arg5, arg6);
        assert!(0x2::coin::value<T0>(&v2) >= arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    entry fun arb_cetus_bluefin<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_cetus::Pool<T0, T1>, arg2: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_bluefin::Pool<T0, T1>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 2);
        let v1 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_cetus::swap_a_to_b<T0, T1>(arg1, arg0, v0, 0, arg4, arg5, arg6);
        let v2 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_bluefin::swap_b_to_a<T0, T1>(arg2, v1, 0x2::coin::value<T1>(&v1), 0, arg5, arg6);
        assert!(0x2::coin::value<T0>(&v2) >= arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    entry fun arb_cetus_deepbook<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_cetus::Pool<T0, T1>, arg2: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_deepbook::Pool<T0, T1>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 2);
        let v1 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_cetus::swap_a_to_b<T0, T1>(arg1, arg0, v0, 0, arg4, arg5, arg6);
        let v2 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_deepbook::swap_b_to_a<T0, T1>(arg2, v1, 0x2::coin::value<T1>(&v1), 0, arg5, arg6);
        assert!(0x2::coin::value<T0>(&v2) >= arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    entry fun arb_cetus_kriya<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_cetus::Pool<T0, T1>, arg2: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_kriya::Pool<T0, T1>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 2);
        let v1 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_cetus::swap_a_to_b<T0, T1>(arg1, arg0, v0, 0, arg4, arg5, arg6);
        let v2 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_kriya::swap_b_to_a<T0, T1>(arg2, v1, 0x2::coin::value<T1>(&v1), 0, arg5, arg6);
        assert!(0x2::coin::value<T0>(&v2) >= arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    entry fun arb_cetus_turbos<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_cetus::Pool<T0, T1>, arg2: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_turbos::Pool<T0, T1>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 2);
        let v1 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_cetus::swap_a_to_b<T0, T1>(arg1, arg0, v0, 0, arg4, arg5, arg6);
        let v2 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_turbos::swap_b_to_a<T0, T1>(arg2, v1, 0x2::coin::value<T1>(&v1), 0, arg5, arg6);
        assert!(0x2::coin::value<T0>(&v2) >= arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    entry fun arb_deepbook_aftermath<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_deepbook::Pool<T0, T1>, arg2: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_aftermath::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 2);
        let v1 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_deepbook::swap_a_to_b<T0, T1>(arg1, arg0, v0, 0, arg4, arg5);
        let v2 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_aftermath::swap_b_to_a<T0, T1>(arg2, v1, 0x2::coin::value<T1>(&v1), 0, arg4, arg5);
        assert!(0x2::coin::value<T0>(&v2) >= arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg5));
    }

    entry fun arb_deepbook_bluefin<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_deepbook::Pool<T0, T1>, arg2: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_bluefin::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 2);
        let v1 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_deepbook::swap_a_to_b<T0, T1>(arg1, arg0, v0, 0, arg4, arg5);
        let v2 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_bluefin::swap_b_to_a<T0, T1>(arg2, v1, 0x2::coin::value<T1>(&v1), 0, arg4, arg5);
        assert!(0x2::coin::value<T0>(&v2) >= arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg5));
    }

    entry fun arb_deepbook_cetus<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_deepbook::Pool<T0, T1>, arg2: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_cetus::Pool<T0, T1>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 2);
        let v1 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_deepbook::swap_a_to_b<T0, T1>(arg1, arg0, v0, 0, arg5, arg6);
        let v2 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_cetus::swap_b_to_a<T0, T1>(arg2, v1, 0x2::coin::value<T1>(&v1), 0, arg4, arg5, arg6);
        assert!(0x2::coin::value<T0>(&v2) >= arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    entry fun arb_deepbook_kriya<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_deepbook::Pool<T0, T1>, arg2: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_kriya::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 2);
        let v1 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_deepbook::swap_a_to_b<T0, T1>(arg1, arg0, v0, 0, arg4, arg5);
        let v2 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_kriya::swap_b_to_a<T0, T1>(arg2, v1, 0x2::coin::value<T1>(&v1), 0, arg4, arg5);
        assert!(0x2::coin::value<T0>(&v2) >= arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg5));
    }

    entry fun arb_deepbook_turbos<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_deepbook::Pool<T0, T1>, arg2: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_turbos::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 2);
        let v1 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_deepbook::swap_a_to_b<T0, T1>(arg1, arg0, v0, 0, arg4, arg5);
        let v2 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_turbos::swap_b_to_a<T0, T1>(arg2, v1, 0x2::coin::value<T1>(&v1), 0, arg4, arg5);
        assert!(0x2::coin::value<T0>(&v2) >= arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg5));
    }

    entry fun arb_kriya_aftermath<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_kriya::Pool<T0, T1>, arg2: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_aftermath::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 2);
        let v1 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_kriya::swap_a_to_b<T0, T1>(arg1, arg0, v0, 0, arg4, arg5);
        let v2 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_aftermath::swap_b_to_a<T0, T1>(arg2, v1, 0x2::coin::value<T1>(&v1), 0, arg4, arg5);
        assert!(0x2::coin::value<T0>(&v2) >= arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg5));
    }

    entry fun arb_kriya_bluefin<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_kriya::Pool<T0, T1>, arg2: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_bluefin::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 2);
        let v1 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_kriya::swap_a_to_b<T0, T1>(arg1, arg0, v0, 0, arg4, arg5);
        let v2 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_bluefin::swap_b_to_a<T0, T1>(arg2, v1, 0x2::coin::value<T1>(&v1), 0, arg4, arg5);
        assert!(0x2::coin::value<T0>(&v2) >= arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg5));
    }

    entry fun arb_kriya_cetus<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_kriya::Pool<T0, T1>, arg2: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_cetus::Pool<T0, T1>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 2);
        let v1 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_kriya::swap_a_to_b<T0, T1>(arg1, arg0, v0, 0, arg5, arg6);
        let v2 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_cetus::swap_b_to_a<T0, T1>(arg2, v1, 0x2::coin::value<T1>(&v1), 0, arg4, arg5, arg6);
        assert!(0x2::coin::value<T0>(&v2) >= arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    entry fun arb_kriya_deepbook<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_kriya::Pool<T0, T1>, arg2: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_deepbook::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 2);
        let v1 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_kriya::swap_a_to_b<T0, T1>(arg1, arg0, v0, 0, arg4, arg5);
        let v2 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_deepbook::swap_b_to_a<T0, T1>(arg2, v1, 0x2::coin::value<T1>(&v1), 0, arg4, arg5);
        assert!(0x2::coin::value<T0>(&v2) >= arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg5));
    }

    entry fun arb_kriya_turbos<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_kriya::Pool<T0, T1>, arg2: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_turbos::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 2);
        let v1 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_kriya::swap_a_to_b<T0, T1>(arg1, arg0, v0, 0, arg4, arg5);
        let v2 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_turbos::swap_b_to_a<T0, T1>(arg2, v1, 0x2::coin::value<T1>(&v1), 0, arg4, arg5);
        assert!(0x2::coin::value<T0>(&v2) >= arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg5));
    }

    entry fun arb_turbos_aftermath<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_turbos::Pool<T0, T1>, arg2: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_aftermath::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 2);
        let v1 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_turbos::swap_a_to_b<T0, T1>(arg1, arg0, v0, 0, arg4, arg5);
        let v2 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_aftermath::swap_b_to_a<T0, T1>(arg2, v1, 0x2::coin::value<T1>(&v1), 0, arg4, arg5);
        assert!(0x2::coin::value<T0>(&v2) >= arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg5));
    }

    entry fun arb_turbos_bluefin<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_turbos::Pool<T0, T1>, arg2: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_bluefin::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 2);
        let v1 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_turbos::swap_a_to_b<T0, T1>(arg1, arg0, v0, 0, arg4, arg5);
        let v2 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_bluefin::swap_b_to_a<T0, T1>(arg2, v1, 0x2::coin::value<T1>(&v1), 0, arg4, arg5);
        assert!(0x2::coin::value<T0>(&v2) >= arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg5));
    }

    entry fun arb_turbos_cetus<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_turbos::Pool<T0, T1>, arg2: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_cetus::Pool<T0, T1>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 2);
        let v1 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_turbos::swap_a_to_b<T0, T1>(arg1, arg0, v0, 0, arg5, arg6);
        let v2 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_cetus::swap_b_to_a<T0, T1>(arg2, v1, 0x2::coin::value<T1>(&v1), 0, arg4, arg5, arg6);
        assert!(0x2::coin::value<T0>(&v2) >= arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
    }

    entry fun arb_turbos_deepbook<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_turbos::Pool<T0, T1>, arg2: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_deepbook::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 2);
        let v1 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_turbos::swap_a_to_b<T0, T1>(arg1, arg0, v0, 0, arg4, arg5);
        let v2 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_deepbook::swap_b_to_a<T0, T1>(arg2, v1, 0x2::coin::value<T1>(&v1), 0, arg4, arg5);
        assert!(0x2::coin::value<T0>(&v2) >= arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg5));
    }

    entry fun arb_turbos_kriya<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_turbos::Pool<T0, T1>, arg2: &mut 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_kriya::Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 2);
        let v1 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_turbos::swap_a_to_b<T0, T1>(arg1, arg0, v0, 0, arg4, arg5);
        let v2 = 0x4e38403e87e0139c5a13d60d0ea256111eb693e59879c829610c5a23c98512cb::dex_kriya::swap_b_to_a<T0, T1>(arg2, v1, 0x2::coin::value<T1>(&v1), 0, arg4, arg5);
        assert!(0x2::coin::value<T0>(&v2) >= arg3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

