module 0xa6e110c26ca8cbf110c17a0e5199dc86df581047035bdc8ffe9840d49a87e297::unlock {
    public fun asset_from_kiosk_to_burn(arg0: 0xa6e110c26ca8cbf110c17a0e5199dc86df581047035bdc8ffe9840d49a87e297::golden_key::GoldenKey, arg1: &0xa6e110c26ca8cbf110c17a0e5199dc86df581047035bdc8ffe9840d49a87e297::proxy::ProtectedTP<0xa6e110c26ca8cbf110c17a0e5199dc86df581047035bdc8ffe9840d49a87e297::golden_key::GoldenKey>, arg2: 0x2::transfer_policy::TransferRequest<0xa6e110c26ca8cbf110c17a0e5199dc86df581047035bdc8ffe9840d49a87e297::golden_key::GoldenKey>, arg3: &0xa6e110c26ca8cbf110c17a0e5199dc86df581047035bdc8ffe9840d49a87e297::golden_key::Version, arg4: &mut 0xa6e110c26ca8cbf110c17a0e5199dc86df581047035bdc8ffe9840d49a87e297::golden_key::GkSupply) {
        0xa6e110c26ca8cbf110c17a0e5199dc86df581047035bdc8ffe9840d49a87e297::golden_key::checkVersion(arg3, 1);
        let (v0, _, _) = 0x2::transfer_policy::confirm_request<0xa6e110c26ca8cbf110c17a0e5199dc86df581047035bdc8ffe9840d49a87e297::golden_key::GoldenKey>(0xa6e110c26ca8cbf110c17a0e5199dc86df581047035bdc8ffe9840d49a87e297::proxy::transfer_policy<0xa6e110c26ca8cbf110c17a0e5199dc86df581047035bdc8ffe9840d49a87e297::golden_key::GoldenKey>(arg1), arg2);
        assert!(0x2::object::id<0xa6e110c26ca8cbf110c17a0e5199dc86df581047035bdc8ffe9840d49a87e297::golden_key::GoldenKey>(&arg0) == v0, 1);
        0xa6e110c26ca8cbf110c17a0e5199dc86df581047035bdc8ffe9840d49a87e297::golden_key::burn_golden_key(arg0, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

