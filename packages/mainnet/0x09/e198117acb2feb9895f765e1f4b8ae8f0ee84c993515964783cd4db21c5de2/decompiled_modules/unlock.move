module 0x9e198117acb2feb9895f765e1f4b8ae8f0ee84c993515964783cd4db21c5de2::unlock {
    public fun asset_from_kiosk_to_burn(arg0: 0x9e198117acb2feb9895f765e1f4b8ae8f0ee84c993515964783cd4db21c5de2::golden_key::GoldenKey, arg1: &0x9e198117acb2feb9895f765e1f4b8ae8f0ee84c993515964783cd4db21c5de2::proxy::ProtectedTP<0x9e198117acb2feb9895f765e1f4b8ae8f0ee84c993515964783cd4db21c5de2::golden_key::GoldenKey>, arg2: 0x2::transfer_policy::TransferRequest<0x9e198117acb2feb9895f765e1f4b8ae8f0ee84c993515964783cd4db21c5de2::golden_key::GoldenKey>, arg3: &0x9e198117acb2feb9895f765e1f4b8ae8f0ee84c993515964783cd4db21c5de2::golden_key::Version, arg4: &mut 0x9e198117acb2feb9895f765e1f4b8ae8f0ee84c993515964783cd4db21c5de2::golden_key::GkSupply) {
        0x9e198117acb2feb9895f765e1f4b8ae8f0ee84c993515964783cd4db21c5de2::golden_key::checkVersion(arg3, 1);
        let (v0, _, _) = 0x2::transfer_policy::confirm_request<0x9e198117acb2feb9895f765e1f4b8ae8f0ee84c993515964783cd4db21c5de2::golden_key::GoldenKey>(0x9e198117acb2feb9895f765e1f4b8ae8f0ee84c993515964783cd4db21c5de2::proxy::transfer_policy<0x9e198117acb2feb9895f765e1f4b8ae8f0ee84c993515964783cd4db21c5de2::golden_key::GoldenKey>(arg1), arg2);
        assert!(0x2::object::id<0x9e198117acb2feb9895f765e1f4b8ae8f0ee84c993515964783cd4db21c5de2::golden_key::GoldenKey>(&arg0) == v0, 1);
        0x9e198117acb2feb9895f765e1f4b8ae8f0ee84c993515964783cd4db21c5de2::golden_key::burn_golden_key(arg0, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

