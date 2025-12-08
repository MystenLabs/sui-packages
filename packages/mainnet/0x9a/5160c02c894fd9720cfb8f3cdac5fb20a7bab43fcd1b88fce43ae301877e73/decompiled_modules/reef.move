module 0x9a5160c02c894fd9720cfb8f3cdac5fb20a7bab43fcd1b88fce43ae301877e73::reef {
    public fun on_query_settled<T0, T1>(arg0: &0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query::Query<T0>, arg1: 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::callback::QuerySettled, arg2: &mut 0xb3aed6cae5afa34d74da7e3e8de627bfdf54009563f38cc244d9c1cefc22068f::market::Market<T1>, arg3: &0x2::clock::Clock) {
        assert!(0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::callback::query_settled_query_id(&arg1) == 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query::id<T0>(arg0), 1);
        assert!(0x1::option::some<0x2::object::ID>(0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::callback::query_settled_query_id(&arg1)) == 0xb3aed6cae5afa34d74da7e3e8de627bfdf54009563f38cc244d9c1cefc22068f::market::oracle_id<T1>(arg2), 1);
        0x9a5160c02c894fd9720cfb8f3cdac5fb20a7bab43fcd1b88fce43ae301877e73::coral::resolve_market_<T1>(arg2, 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::callback::query_settled_data(&arg1), arg3);
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::callback::verify_query_settled<0x9a5160c02c894fd9720cfb8f3cdac5fb20a7bab43fcd1b88fce43ae301877e73::coral::CoralWitness>(arg1, 0x9a5160c02c894fd9720cfb8f3cdac5fb20a7bab43fcd1b88fce43ae301877e73::coral::witness());
    }

    // decompiled from Move bytecode v6
}

